import React from 'react';

export default function Page() {
  return (
    <section className="bg-black text-white">
      <div className="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">
        <a href="#" className="flex items-center mb-6 text-2xl font-semibold text-white">
          Register
        </a>
        <div className="w-full bg-black rounded-lg shadow border md:mt-0 sm:max-w-md xl:p-0 border-gray-300 dark:border-gray-600">
          <div className="p-6 space-y-4 md:space-y-6 sm:p-8">
            <h1 className="text-xl font-bold leading-tight tracking-tight text-white md:text-2xl">
              Create an account
            </h1>
            <form className="space-y-4 md:space-y-6" action="#">
              <div>
                <label htmlFor="email" className="block mb-2 text-sm font-medium text-white">
                  Your ID
                </label>
                <input
                  type="email"
                  name="email"
                  id="email"
                  className="bg-black border border-white text-white sm:text-sm rounded-lg focus:ring-white focus:border-white block w-full p-2.5"
                  placeholder="ID here"
                  required=""
                />
              </div>
              <div>
                <label htmlFor="password" className="block mb-2 text-sm font-medium text-white">
                  Password
                </label>
                <input
                  type="password"
                  name="password"
                  id="password"
                  placeholder="••••••••"
                  className="bg-black border border-white text-white sm:text-sm rounded-lg focus:ring-white focus:border-white block w-full p-2.5"
                  required=""
                />
              </div>
              <div>
                <label htmlFor="confirm-password" className="block mb-2 text-sm font-medium text-white">
                  Confirm password
                </label>
                <input
                  type="password"
                  name="confirm-password"
                  id="confirm-password"
                  placeholder="••••••••"
                  className="bg-black border border-white text-white sm:text-sm rounded-lg focus:ring-white focus:border-white block w-full p-2.5"
                  required=""
                />
              </div>
              <div className="flex items-start">
                <div className="flex items-center h-5">
                  <input
                    id="terms"
                    aria-describedby="terms"
                    type="checkbox"
                    className="w-4 h-4 border border-white rounded bg-black focus:ring-3 focus:ring-white"
                    required=""
                  />
                </div>
                <div className="ml-3 text-sm">
                  <label htmlFor="terms" className="font-light text-gray-400">
                    I accept the{' '}
                    <a className="font-medium text-white hover:underline" href="#">
                      Terms and Conditions
                    </a>
                  </label>
                </div>
              </div>
              <button
                type="submit"
                className="w-full text-black bg-white hover:bg-gray-200 focus:ring-4 focus:outline-none focus:ring-white font-medium rounded-lg text-sm px-5 py-2.5 text-center"
              >
                Create an account
              </button>
              <p className="text-sm font-light text-gray-400">
                Already have an account?{' '}
                <a href="#" className="font-medium text-white hover:underline">
                  Login here
                </a>
              </p>
            </form>
          </div>
        </div>
      </div>
    </section>
  );
}
