#include <cuda_runtime.h>

__global__ void vector_add(const float* A, const float* B, float* C, int N) {
    // Store N element-wise results in C; this kernel returns no value.
    int thread_id = threadIdx.x;
    int block_id = blockIdx.x;
    int thread_num = blockDim.x;
    int block_num = gridDim.x;

    int idx = block_id * thread_num + thread_id;
    if(idx < N){
        C[idx] = A[idx] + B[idx];
    }
    
}

extern "C" void solve(const float* A, const float* B, float* C, int N) {
    int threads = 256;
    int blocks = (N + threads - 1) / threads;
    vector_add<<<blocks, threads>>>(A, B, C, N);
    cudaDeviceSynchronize();
}